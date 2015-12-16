From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
Date: Wed, 16 Dec 2015 18:45:23 +0100
Message-ID: <20151216174523.GH29775@pd.tnic>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
 <20151216122642.GE29775@pd.tnic>
 <1450280642.29051.76.camel@hpe.com>
 <20151216154916.GF29775@pd.tnic>
 <1450283759.20148.11.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1450283759.20148.11.camel@hpe.com>
Sender: owner-linux-mm@kvack.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 16, 2015 at 09:35:59AM -0700, Toshi Kani wrote:
> We do not have enough bits left to cover any potential future use-cases
> with other strings if we are going to get rid of strcmp() completely.

Look at the examples I gave. I'm talking about having an additional
identifier which can be a number and not a bit.

>  Since the searches from crash and kexec are one-time thing, and einj
> is a R&D tool, I think we can leave the strcmp() check for these
> special cases, and keep the interface flexible with any strings.

I don't think using strings is anywhere close to flexible. If at all, it
is an odd use case which shouldnt've been allowed in in the first place.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
