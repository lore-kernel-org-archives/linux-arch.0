From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Tue, 9 Jan 2018 14:35:48 -0800
Message-ID: <CAPcyv4g502B4DK9ZVT0m3T-CRAMnZ3+R6v_hPga6mQAtQAGM_A@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180109214149.yo3tnjesezgz63x4@treble> <CAPcyv4iUOWivipi1vjwm691dANBFq+H5Ztgtt-dzDjchbaDT-g@mail.gmail.com>
 <20180109214902.2d4ptkld2bof3js7@treble> <CAPcyv4iit=mESt2Mh0Wbvag3=tV6vEZt=NsHPUnj3ksgRzQKiQ@mail.gmail.com>
 <20180109222348.twmw62qwfhefqpoe@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180109222348.twmw62qwfhefqpoe@treble>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 9, 2018 at 2:23 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Tue, Jan 09, 2018 at 01:59:04PM -0800, Dan Williams wrote:
>> > Right, but what's the purpose of preventing speculation past
>> > access_ok()?
>>
>> Caution. It's the same rationale for the nospec_array_ptr() patches.
>> If we, kernel community, can identify any possible speculation past a
>> bounds check we should inject a speculation mitigation. Unless there's
>> a way to be 100% certain that the first unwanted speculation can be
>> turned into a gadget later on in the instruction stream, err on the
>> side of shutting it down early.
>
> I'm all for being cautious.  The nospec_array_ptr() patches are fine,
> and they make sense in light of the variant 1 CVE.
>
> But that still doesn't answer my question.  I haven't seen *any*
> rationale for this patch.  It would be helpful to at least describe
> what's being protected against, even if it's hypothetical.  How can we
> review it if the commit log doesn't describe its purpose?

Certainly the changelog needs improvement, I'll roll these concerns
into v2 and we can go from there.
