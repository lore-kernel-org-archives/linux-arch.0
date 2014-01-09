From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v2 1/5] mm: create generic early_ioremap() support
Date: Thu, 9 Jan 2014 10:15:42 +0000
Message-ID: <20140109101542.GD18441@console-pimps.org>
References: <1389062120-31896-1-git-send-email-msalter@redhat.com>
 <1389062120-31896-2-git-send-email-msalter@redhat.com>
 <52CC89B4.4060300@zytor.com>
 <1389197388.29144.37.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1389197388.29144.37.camel@deneb.redhat.com>
Sender: owner-linux-mm@kvack.org
To: Mark Salter <msalter@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, patches@linaro.org, linux-mm@kvack.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Young <dyoung@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 08 Jan, at 11:09:48AM, Mark Salter wrote:
> 
> Ok, that sounds like a good idea. I'm uncertain how best to coordinate
> with Dave Young's patch series to avoid conflicts. His first patch does
> the signature change (and adds the early_memunmap function but that
> isn't used anywhere):
> 
>  https://lkml.org/lkml/2013/12/20/143
> 
> Any thoughts on how best to avoid potential merge conflicts here?

Dave's patch hasn't been picked up by anyone so far, so you could
incorporate it into your series.

-- 
Matt Fleming, Intel Open Source Technology Center

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
