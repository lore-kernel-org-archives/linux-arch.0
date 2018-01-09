From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Tue, 9 Jan 2018 13:47:09 -0800
Message-ID: <CAPcyv4iUOWivipi1vjwm691dANBFq+H5Ztgtt-dzDjchbaDT-g@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com> <20180109214149.yo3tnjesezgz63x4@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180109214149.yo3tnjesezgz63x4@treble>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 9, 2018 at 1:41 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Fri, Jan 05, 2018 at 06:52:07PM -0800, Linus Torvalds wrote:
>> On Fri, Jan 5, 2018 at 5:10 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> > From: Andi Kleen <ak@linux.intel.com>
>> >
>> > When access_ok fails we should always stop speculating.
>> > Add the required barriers to the x86 access_ok macro.
>>
>> Honestly, this seems completely bogus.
>>
>> The description is pure garbage afaik.
>>
>> The fact is, we have to stop speculating when access_ok() does *not*
>> fail - because that's when we'll actually do the access. And it's that
>> access that needs to be non-speculative.
>>
>> That actually seems to be what the code does (it stops speculation
>> when __range_not_ok() returns false, but access_ok() is
>> !__range_not_ok()). But the explanation is crap, and dangerous.
>
> The description also seems to be missing the "why", as it's not
> self-evident (to me, at least).
>
> Isn't this (access_ok/uaccess_begin/ASM_STAC) too early for the lfence?
>
> i.e., wouldn't the pattern be:
>
>         get_user(uval, uptr);
>         if (uval < array_size) {
>                 lfence();
>                 foo = a2[a1[uval] * 256];
>         }
>
> Shouldn't the lfence come much later, *after* reading the variable and
> comparing it and branching accordingly?

The goal of putting the lfence in uaccess_begin() is to prevent
speculation past access_ok(). You are correct that the cpu could later
mis-speculate on uval, that's where taint analysis tooling needs to
come into play to track uval to where it is used. That's where the
nospec_array_ptr() patches come into play.
