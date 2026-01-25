Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DF3EBF00
	for <linux-arch@vger.kernel.org>; Sun, 25 Jan 2026 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769313337; cv=none; b=b+cHhH+ZuZEFBtMmA/xr5KScx9478b3nU3T2QSZzhSy/P7ZljqfFSt35J/Ay1Mnbal19swC0KTQKWWWjfz5JIfQNetbUzAspchTQqTrzK/f+K/oL0nT2TRNsf7JYX36D7aP7eAfYRTTXJoutnFHvCtVg0Jb9+VIY6C/jtzFVQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769313337; c=relaxed/simple;
	bh=9skYrSElwzNljozXGmzQbmTB3X5ciFpsVvS1i3nXL5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8QDnp6EAazauFNc3ZEYwueASGDqV97OJJXn/25NTOH5KQwKDSCp/MPkWmfi4IymZjEWFV6r8ViiPcfC3nlyoeo0z8DUkdF0EMOUJGjvIcCyllznBmh0TXg7zE28LbAsd+TPcC0QX9cfVj6CsdN/cN33xNBu7jrTBiXPKuf8ocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un27DZ3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un27DZ3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD93C4CEF1
	for <linux-arch@vger.kernel.org>; Sun, 25 Jan 2026 03:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769313337;
	bh=9skYrSElwzNljozXGmzQbmTB3X5ciFpsVvS1i3nXL5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=un27DZ3lS6cVoBMtNgGY6Yzz/RynkWH/Lws/mNjUnkG71hIfRiHfJRWhzphdPk2Qr
	 8YXeaUJsGdF7rys6SkIJsCGd+tdtDR/mUAg+/yyRB7hf+HTzWBf3NpnJpkbox5EOcD
	 bl61CGa7TOnAAh7bjbGLkVKjd84/404Nj3eo/uLxL/dWiyFHO3YYhT0VEpFflPHLmE
	 R5Q8cHR3TRNbZym+IVEWvCXwgW8XDrhG2z/5QW1aTYDakfz1taSMloOZ7gExxx7aJT
	 vsqSkJYrl8An5lje3bzupwgXum9pLFovZTIa2lIAqaf8GFw7eMv51P+9NnUBkv5thk
	 3QOIrnu+1P3bQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b885a18f620so408165866b.3
        for <linux-arch@vger.kernel.org>; Sat, 24 Jan 2026 19:55:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2F0NY1fu8jEu+5gkhDPyi7BrbplQbjXFGGpmB2WS2T1A3akqbDYMbDw7rQbKUhIWLs56JOcx5pTVY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz674v8osOaRY1nww9/IgGdTUOb3nAKqITXZQJifrZtvARgKDkF
	Lfrj9U3kGsrRfBUdAjFR2Bm9r6ZUkqja/+tX1OHM2RDtzuKk2gGvDCZ8AlzIipJB0wvFIWsDcaJ
	Se4WkB/X7QSVFl8KUDVXAHXQcz4zFnek=
X-Received: by 2002:a17:907:da9:b0:b88:783e:64f9 with SMTP id
 a640c23a62f3a-b8d20d6ef05mr41531766b.25.1769313335629; Sat, 24 Jan 2026
 19:55:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107094007.966496-1-john.g.garry@oracle.com> <20260107094007.966496-3-john.g.garry@oracle.com>
In-Reply-To: <20260107094007.966496-3-john.g.garry@oracle.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 25 Jan 2026 11:55:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6qAtsBF3jwxbYGEUytZXH2ZRPfzPtUZRBnXOiZ_K5bYg@mail.gmail.com>
X-Gm-Features: AZwV_QjYWuO3o9bzEbS1XM5AmxKORXSwoxVWvGO08slAjXNfx2imuW1HbO_-Bes
Message-ID: <CAAhV-H6qAtsBF3jwxbYGEUytZXH2ZRPfzPtUZRBnXOiZ_K5bYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE
To: John Garry <john.g.garry@oracle.com>
Cc: kernel@xen0n.name, jiaxun.yang@flygoat.com, tsbogend@alpha.franken.de, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org, 
	peterz@infradead.org, arnd@arndb.de, x86@kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-arch@vger.kernel.org, vulab@iscas.ac.cn, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Wed, Jan 7, 2026 at 5:48=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - whi=
ch
> is a valid index - so add a check for this.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  arch/loongarch/include/asm/topology.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/inclu=
de/asm/topology.h
> index f06e7ff25bb7c..6b79d6183085a 100644
> --- a/arch/loongarch/include/asm/topology.h
> +++ b/arch/loongarch/include/asm/topology.h
> @@ -12,7 +12,7 @@
>
>  extern cpumask_t cpus_on_node[];
>
> -#define cpumask_of_node(node)  (&cpus_on_node[node])
> +#define cpumask_of_node(node)  ((node) =3D=3D NUMA_NO_NODE ? cpu_all_mas=
k : &cpus_on_node[node])
>
>  struct pci_bus;
>  extern int pcibus_to_node(struct pci_bus *);
> --
> 2.43.5
>
