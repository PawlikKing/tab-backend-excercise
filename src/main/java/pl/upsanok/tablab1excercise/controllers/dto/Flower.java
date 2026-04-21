package pl.upsanok.tablab1excercise.controllers.dto;

public record Flower(String name) {
    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private String name;

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Flower build() {
            return new Flower(name);
        }
    }
}
