From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Fri, 12 Aug 2016 15:17:06 +0100
Message-ID: <6bc288d9-6bea-1ee2-572f-d397221adaff@arm.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160812123314.GX1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160812123314.GX1041@n2100.armlinux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Alan Modra <amodra@gmail.com>, linux-kbuild@vger.kernel.org, Julian Brown <julian@codesourcery.com>, Michal Marek <mmarek@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 12/08/16 13:33, Russell King - ARM Linux wrote:
> On Fri, Aug 12, 2016 at 06:19:17PM +1000, Nicholas Piggin wrote:
>> This patch adds an option which defaults to "y" in cases where we
>> could possibly be running Cortex A8 and using Thumb2 instructions.
>> In reality the workaround might not be required at all for the kernel
>> if virtual instruction memory is linear in physical memory.
> 
> Hmm.
> 
> The main kernel image is guaranteed to be contiguous in physical memory
> for all sorts of reasons, so this really isn't a concern for the kernel
> itself.

I'm not sure being contiguous matters much - looking at the errata doc,
the implication is that the branch is supposed to use bits 31:12 of the
address of the first page, but under the erratum conditions ends up
taking bits 31:12 of the address of the _second_ page instead. There
doesn't seem to be any importance of where those pages actually are
relative to each other.

> Modules, however, are a different matter, as they are mapped in using
> individual pages, and are most likely to be non-contiguous in physical
> memory.  The kernel's module linker knows nothing about this errata,
> so it'll generally just fix up the relocations in the most basic of
> ways.
> 
> So, I think we should always use this --no-fix-cortex-a8 option where
> the linker supports it irrespective of whether we're running on a core
> needing this workaround, but we probably need to fix the kernel module
> linker to know about this.

Given the above, I'm not convinced that sounds safe, but then I can't
claim to have fist-hand experience with this bug either.

Robin.
