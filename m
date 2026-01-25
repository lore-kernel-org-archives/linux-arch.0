Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2021773D
	for <linux-arch@vger.kernel.org>; Sun, 25 Jan 2026 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769313364; cv=none; b=JKpcHjBrZoL8XkhwKFNfMuZOmkIUCRTi9edAbFQfF8xz78LCpWSLZ7aJwZUJQqQtnl/X0VNJQbf4Y91GoZ9gOE0YvfTpGPVKADc7zR/jTPGKgb2JbLpGwDuYsmdxhrHi72wh9lUqFXMLZ7Zm/CJbJdn0FgPRCn7D8aRYyvDi/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769313364; c=relaxed/simple;
	bh=/f1+7UOgGkVjs1SCjiEZKGF+07uE5XxuDdDNXaQI57I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USzWY7pDp24V2nYCHUnuKyCKhDIE/7EtPpaMARI63mG1fauCBjKgSvFPmF7jgipgto3cOO0MbGz04YfXggP7l0cO8IaGc7uqy4wm2ZM7aP/8XVsth9iVF78uQS0vDMLsrJqE2Ck7SqxY7fuZ9LGT1NipSslDUEKVdntHF1faFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyFn+yE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyFn+yE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA48AC4AF0C
	for <linux-arch@vger.kernel.org>; Sun, 25 Jan 2026 03:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769313363;
	bh=/f1+7UOgGkVjs1SCjiEZKGF+07uE5XxuDdDNXaQI57I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hyFn+yE84ehsZy2gAiLSbNIbNX4R6jya1UMPThelFi7+DRO1dcObe7g400EzNk7Q3
	 Tps7Him+6vQ5EUXIl9Z662ige8uu3fTXxKK66pF3wyuPrhWQ8274LveFHkoCuza0xE
	 gcx9SGqTngwGTZARlw/0IfTVgAna3hw+CMV4KgdjAJj5NOgQD8BD2OXjCJcRbdvSTP
	 KABY2ExnQKLqAg015kRQivbsss9LB0Q1CiQImcOm3i4P9gdoJb8AVVFvtHJm3VJFeu
	 Cek4R84M3xWF+9ZuNylwOY6+3VMB3G/M3On9pnC3FmAb3VXtddTY2EKbGqcnZFVenn
	 lHL6RYAta9yOg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b885e8c679bso324547766b.1
        for <linux-arch@vger.kernel.org>; Sat, 24 Jan 2026 19:56:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtJ3/oQedRZzKXXzZ1XfVMBHm8hfpVCGKVWLTY3hdz2gyDFaU73MjCDPeyrhwapQSfskqeVXryDzpF@vger.kernel.org
X-Gm-Message-State: AOJu0YwrE79b9Ma9Cwz7zqpxNC73tZ2svqMKzQ7kb18GUvsDv6HOzd63
	Zj10Cva/twK9N8n1HKdxDEa1LnZPNPHVtzrBTpxTWJfrYTkw9SvsUFXv29wCOR52uZph1E9Otq2
	MTQp19nnBk0zZONuWGVTULHwBzBWi060=
X-Received: by 2002:a17:907:7216:b0:b88:46c5:eebd with SMTP id
 a640c23a62f3a-b8d2e88593emr36775966b.53.1769313362261; Sat, 24 Jan 2026
 19:56:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107094007.966496-1-john.g.garry@oracle.com> <20260107094007.966496-4-john.g.garry@oracle.com>
In-Reply-To: <20260107094007.966496-4-john.g.garry@oracle.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 25 Jan 2026 11:55:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5RnDi1krGk4g7YuLuY+Pus6VcTadvBED4MCjX45m7YmQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgk7R8rjySKmIYnvNtzJrxlQDAqUhYwpThiwpEBDZVHLR-hS1aIVV3_6Ok
Message-ID: <CAAhV-H5RnDi1krGk4g7YuLuY+Pus6VcTadvBED4MCjX45m7YmQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] MIPS: Loongson: Make cpumask_of_node() robust
 against NUMA_NO_NODE
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

On Wed, Jan 7, 2026 at 5:51=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - whi=
ch
> is a valid index - so add a check for this.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  arch/mips/include/asm/mach-loongson64/topology.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips=
/include/asm/mach-loongson64/topology.h
> index 3414a1fd17835..89bb4deab98a6 100644
> --- a/arch/mips/include/asm/mach-loongson64/topology.h
> +++ b/arch/mips/include/asm/mach-loongson64/topology.h
> @@ -7,7 +7,7 @@
>  #define cpu_to_node(cpu)       (cpu_logical_map(cpu) >> 2)
>
>  extern cpumask_t __node_cpumask[];
> -#define cpumask_of_node(node)  (&__node_cpumask[node])
> +#define cpumask_of_node(node)    ((node) =3D=3D NUMA_NO_NODE ? cpu_all_m=
ask : &__node_cpumask[node])
>
>  struct pci_bus;
>  extern int pcibus_to_node(struct pci_bus *);
> --
> 2.43.5
>
