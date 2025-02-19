package Model;

public class Aluno extends Pessoas{
    // Atributos (Encapsulamento)
    private String matricula;
    private double nota;
    // Métodos 
    // Cosntrutor
    public Aluno(String nome, String cpf, String matricula) {
        super(nome, cpf);
        this.matricula = matricula;
    }
    // Métodos Getters e Setters
    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    public double getNota() {
        return nota;
    }
    public void setNota(double nota) {
        this.nota = nota;
    }
    // Sobreescrita do exibir informações
    @Override
    public void exibirInformacoes() {
        super.exibirInformacoes();
        System.out.println("Matricula: " +matricula);
        System.out.println("Nota: " +nota);
    }
}