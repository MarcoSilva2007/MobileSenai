package Model;

public abstract class Pessoas {
    // Atributos (Encapsulamento)
    private String nome;
    private String cpf;
    /* Métodos
     Construtor*/
    public Pessoas(String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }
    // Getters e Setters
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getCpf() {
        return cpf;
    }
    public void setCpf(String cpf) {
        this.cpf = cpf;
    }
    // Exibir informações 
    public void exibirInformacoes() {
        System.out.println("Nome: " +nome);
        System.out.println("CPF: " +cpf);
    }
}