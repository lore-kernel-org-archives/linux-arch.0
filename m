From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
Date: Wed, 16 Dec 2015 09:52:37 -0800
Message-ID: <CAPcyv4h+n51Z2hskP2+PX44OB47OQwrKcqVr3nrvMzG++qjC+w@mail.gmail.com>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
	<20151216122642.GE29775@pd.tnic>
	<1450280642.29051.76.camel@hpe.com>
	<20151216154916.GF29775@pd.tnic>
	<1450283759.20148.11.camel@hpe.com>
	<20151216174523.GH29775@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20151216174523.GH29775@pd.tnic>
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@alien8.de>
Cc: Toshi Kani <toshi.kani@hpe.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 16, 2015 at 9:45 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Dec 16, 2015 at 09:35:59AM -0700, Toshi Kani wrote:
>> We do not have enough bits left to cover any potential future use-cases
>> with other strings if we are going to get rid of strcmp() completely.
>
> Look at the examples I gave. I'm talking about having an additional
> identifier which can be a number and not a bit.
>
>>  Since the searches from crash and kexec are one-time thing, and einj
>> is a R&D tool, I think we can leave the strcmp() check for these
>> special cases, and keep the interface flexible with any strings.
>
> I don't think using strings is anywhere close to flexible. If at all, it
> is an odd use case which shouldnt've been allowed in in the first place.
>

It's possible that as far as the resource table is concerned the
resource type might just be "reserved".  It may not be until after a
driver loads that we discover the memory range type.  The identifying
string is driver specific at that point.

All this to say that with strcmp we can search for any custom type .
Otherwise I think we're looking at updating the request_region()
interface to take a type parameter.  That makes strcmp capability more
attractive compared to updating a potentially large number of
request_region() call sites.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
