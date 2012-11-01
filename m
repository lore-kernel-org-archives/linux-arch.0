From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 05/40] Revert some of "binfmt_elf: cleanups"
Date: Thu, 1 Nov 2012 13:52:20 +0000
Message-ID: <50927E94.5030400@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-6-git-send-email-james.hogan@imgtec.com> <20626.30795.679924.702597@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:4463 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761197Ab2KANwW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Nov 2012 09:52:22 -0400
In-Reply-To: <20626.30795.679924.702597@pilspetsen.it.uu.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org

On 01/11/12 13:25, Mikael Pettersson wrote:
> James Hogan writes:
>  > The commit "binfmt_elf: cleanups"
>  > (f670d0ecda73b7438eec9ed108680bc5f5362ad8) removed an ifndef elf_map but
>  > this breaks compilation on metag architecture which does define elf_map.
>  > 
>  > This adds the ifndef back in as it was before, but does not affect the
>  > other cleanups made by that patch.
> 
> Since this is part of your patch submission to upstream the metag
> kernel support, I have no objection to reverting this fragment of
> my patch if/when the metag code gets upstreamed.
> 
> Acked-by: Mikael Pettersson <mikpe@it.uu.se>

Thanks Mikael, I'll keep it as part of the metag patch series so that
they go in together.

Cheers
James
