﻿using Microsoft.EntityFrameworkCore;
using SenaiVagasAPI.Contexts;
using SenaiVagasAPI.Domains;
using SenaiVagasAPI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SenaiVagasAPI.Repositories
{
    public class InscricaoRepository : IInscricaoRepository
    {
        ContextBd ctx = new ContextBd();


        public List<Inscricao> Listar()
        {
            return ctx.Inscricao.Include(I => I.IdVagaNavigation).Include(V => V.IdVagaNavigation.FkEmpresaNavigation).ToList();
        }


        public void Cadastrar(Inscricao novaInscricao)
        {
            novaInscricao.StatusIncricao = false;
            ctx.Inscricao.Add(novaInscricao);

            ctx.SaveChanges();
        }

        public void Deletar(int id)
        {
            ctx.Inscricao.Remove(BuscarPorId(id));

            ctx.SaveChanges();
        }

        public void AtualizarStatus(int id, bool statusInscricao)
        {
            Inscricao inscricao = BuscarPorId(id);
            inscricao.StatusIncricao = statusInscricao;
        }

        public Inscricao BuscarPorId(int id)
        {
            return ctx.Inscricao
         .Include(e => e.FkcandidatoNavigation)
         .Include(e => e.IdVagaNavigation).FirstOrDefault(i => i.IdVaga == id);
        }

        public List<Inscricao> BuscarPorVaga(int id)
        {
            return ctx.Inscricao
         .Include(e => e.FkcandidatoNavigation)
         .Include(e => e.IdVagaNavigation).Where(i => i.IdVaga == id).ToList();
        }

        List<Inscricao> IInscricaoRepository.BuscarPorCandidato(int id)
        {
        return ctx.Inscricao
         .Include(V => V.IdVagaNavigation.FkEmpresaNavigation).Where(i => i.FkcandidatoNavigation.FkUsuario == id).ToList();
        }
    }
}
