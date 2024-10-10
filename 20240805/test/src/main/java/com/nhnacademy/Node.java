package com.nhnacademy;

import java.util.UUID;

abstract class Node {
    private final String id;
    private String name;

    public Node(String name) {
        this.id = UUID.randomUUID().toString();
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public abstract void processMessage(String message);
}


class InputNode extends Node {
    public InputNode(String name) {
        super(name);
    }

    @Override
    public void processMessage(String message) {
        System.out.println("[" + getName() + " - ID: " + getId() + "] Received message: " + message);
    }
}

class OutputNode extends Node {
    public OutputNode(String name) {
        super(name);
    }

    @Override
    public void processMessage(String message) {
        System.out.println("[" + getName() + " - ID: " + getId() + "] Sending message: " + message);
    }
}