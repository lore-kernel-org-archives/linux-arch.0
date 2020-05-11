From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Mon, 11 May 2020 12:36:19 -0700
Message-ID: <8D6745B7-0EC2-4FCC-B6FC-E7E1557EB18E@amacapital.net>
References: <20200511191414.GY8135@suse.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200511191414.GY8135@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org


> On May 11, 2020, at 12:14 PM, Joerg Roedel <jroedel@suse.de> wrote:
>=20
> =EF=BB=BFOn Mon, May 11, 2020 at 08:36:31AM -0700, Andy Lutomirski wrote:
>> What if we make 32-bit PTI depend on PAE?
>=20
> It already does, PTI support for legacy paging had to be removed because
> there were memory corruption problems with THP. The reason was that huge
> PTEs in the user-space area were mapped in two page-tables (kernel and
> user), but A/D bits were only fetched from the kernel part. To not make
> things more complicated we agreed on just not supporting PTI without
> PAE.
>=20
>> And drop 32-bit Xen PV support?  And make 32-bit huge pages depend on
>> PAE?  Then 32-bit non-PAE can use the direct-mapped LDT, 32-bit PTI
>> (and optionally PAE non-PTI) can use the evil virtually mapped LDT.
>> And 32-bit non-PAE (the 2-level case) will only have pointers to page
>> tables at the top level.  And then we can preallocate.
>=20
> Not sure I can follow you here. How can 32-bit PTI with PAE use the LDT
> from the direct mapping? I am guessing you want to get rid of the
> SHARED_KERNEL_PMD=3D=3D0 case for PAE kernels.

I wrote nonsense. I mean bite off a piece of the *user* portion of the addre=
ss space and stick the LDT there.

I contemplated doing this when I wrote the 64-bit code, but I decided we had=
 so much address space to throw around that I liked my solution better.

> This would indeed make
> syncing unneccessary on PAE, but pre-allocation would still be needed
> for 2-level paging. Just the amount of memory needed for the
> pre-allocated PTE pages is half as big as it would be with PAE.
>=20
>> Or maybe we don't want to defeature this much, or maybe the memory hit
>> from this preallocation will hurt little 2-level 32-bit systems too
>> much.
>=20
> It will certainly make Linux less likely to boot on low-memory x86-32
> systems, whoever will be affected by this.
>=20
>=20

I=E2=80=99m guessing the right solution is either your series or your series=
 plus preallocation on 64-bit. I=E2=80=99m just grumpy about it...=
