Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288534C808;
	Fri, 30 Jan 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783906; cv=none; b=LY1kLoWVe09FBoS3Aa+YuB7PH7bxpywpb/mSKQ4wE4PcnA765EdfVUYduFS8i9I1leZxTyL3ZF/KJnc95wceRsbMk/H8ySj6QX05k1EZjVKDBdE/EE4u0zBvTRFNuNBSXo5W270kPo1oPLLZxNRxPV0zMbJON5EbBD2rFWaxk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783906; c=relaxed/simple;
	bh=p+NC8Gd1SP5hs+nB4mSjsdjYhzvrrnCa5+V7sBTPhBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YncaUt+KBj2q6+WIBW6AT4TcQQXxSL86fsORtYgh2C8QRssVSqnl6TR6sLul2qE8HeFuWyVG3kwxnu326CLEkT2DexnjOWQMIGouqOXxHT8+eIt6Mf0g+acHUkyFAJPINUd0QYZkaP7wV9Vkie3lkLQRraREQuiyjGFqcduO+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1vlpdb-0007Ep-00; Fri, 30 Jan 2026 15:38:19 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id D8ABBC0113; Fri, 30 Jan 2026 15:34:01 +0100 (CET)
Date: Fri, 30 Jan 2026 15:34:01 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: John Garry <john.g.garry@oracle.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, arnd@arndb.de, x86@kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
	vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org
Subject: Re: [PATCH v2 3/4] MIPS: Loongson: Make cpumask_of_node() robust
 against NUMA_NO_NODE
Message-ID: <aXzBWUBNtearOrz9@alpha.franken.de>
References: <20260107094007.966496-1-john.g.garry@oracle.com>
 <20260107094007.966496-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107094007.966496-4-john.g.garry@oracle.com>

On Wed, Jan 07, 2026 at 09:40:06AM +0000, John Garry wrote:
> The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - which
> is a valid index - so add a check for this.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  arch/mips/include/asm/mach-loongson64/topology.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
> index 3414a1fd17835..89bb4deab98a6 100644
> --- a/arch/mips/include/asm/mach-loongson64/topology.h
> +++ b/arch/mips/include/asm/mach-loongson64/topology.h
> @@ -7,7 +7,7 @@
>  #define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
>  
>  extern cpumask_t __node_cpumask[];
> -#define cpumask_of_node(node)	(&__node_cpumask[node])
> +#define cpumask_of_node(node)	  ((node) == NUMA_NO_NODE ? cpu_all_mask : &__node_cpumask[node])
>  
>  struct pci_bus;
>  extern int pcibus_to_node(struct pci_bus *);
> -- 
> 2.43.5

applied to mips-next
Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
