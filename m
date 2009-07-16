From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] mm: Pass virtual address to
 [__]p{te,ud,md}_free_tlb()
Date: Thu, 16 Jul 2009 11:56:05 +1000
Message-ID: <1247709365.27937.6.camel@pasglop>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	 <1247708177.9851.4.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1247708177.9851.4.camel@concordia>
Sender: owner-linux-mm@kvack.org
To: michael@ellerman.id.au
Cc: Linux Memory Management <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@tiscali.co.uk>
List-Id: linux-arch.vger.kernel.org

On Thu, 2009-07-16 at 11:36 +1000, Michael Ellerman wrote:
> 
> Builds for the important architectures, powerpc, ia64, arm, sparc,
> sparc64, oh and x86:
> 
> http://kisskb.ellerman.id.au/kisskb/head/1976/
> 
> (based on your test branch 34f25476)

Note for all lurkers: the fails in there are unrelated to the patch
(mostly warnings triggering our new Werror and probably mostly fixed
upstream already).

Cheers,
Ben.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
