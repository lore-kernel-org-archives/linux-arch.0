Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:58141
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755559AbaHZCrQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Aug 2014 22:47:16 -0400
Message-ID: <53FBF3C3.90509@gentoo.org>
Date: Mon, 25 Aug 2014 22:41:07 -0400
From: Joshua Kinard <kumba@gentoo.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
References: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com> <20140825171600.GH25892@linux-mips.org> <53FBCD09.1050003@gentoo.org> <53FBD676.8080307@gmail.com>
In-Reply-To: <53FBD676.8080307@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Steven Hill <Steven.Hill@imgtec.com>
Message-ID: <20140826024107.YrZdvv8Nc13SSjdYI9U6Pd4-3FI9EUwfAVJM2lGDF3s@z>

On 08/25/2014 20:36, David Daney wrote:
> On 08/25/2014 04:55 PM, Joshua Kinard wrote:
>> On 08/25/2014 13:16, Ralf Baechle wrote:
>>> On Sat, Aug 02, 2014 at 05:11:37AM +0400, Max Filippov wrote:
>>>
>>>> this series adds mapping color control to the generic kmap code, allowing
>>>> architectures with aliasing VIPT cache to use high memory. There's also
>>>> use example of this new interface by xtensa.
>>>
>>> I haven't actually ported this to MIPS but it certainly appears to be
>>> the right framework to get highmem aliases handled on MIPS, too.
>>>
>>> Though I still consider increasing PAGE_SIZE to 16k the preferable
>>> solution because it will entirly do away with cache aliases.
>>
>> Won't setting PAGE_SIZE to 16k break some existing userlands (o32)?  I use a
>> 4k PAGE_SIZE because the last few times I've tried 16k or 64k, init won't
>> load (SIGSEGVs or such, which panicks the kernel).
>>
> 
> It isn't supposed to break things.  Using "stock" toolchains should result
> in executables that will run with any page size.
> 
> In the past, some geniuses came up with some linker (ld) patches that, in
> order to save a few KB of RAM, produced executables that ran only on 4K pages.
> 
> There were some equally astute Debian emacs package maintainers that were
> carrying emacs patches into Debian that would not work on non-4K page size
> systems.
> 
> That said, I think such thinking should be punished.  The punishment should
> be to not have their software run when we select non-4K page sizes.  The
> vast majority of prepackaged software runs just fine with a larger page size.

Well, it does appear to mostly work now w/ 16k PAGE_SIZE.  The Octane booted
into userland with just a couple of "illegal instruction" errors from 'rm'
and 'mdadm'.  I wonder if that's tied to a hardcoded PAGE_SIZE somewhere.
Have to dig around and find something that reproduces the problem on demand.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
