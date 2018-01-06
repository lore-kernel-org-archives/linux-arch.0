From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sat, 6 Jan 2018 11:36:04 -0800
Message-ID: <CAPcyv4jLGwCTVQAxHH5gob_6CSeXkbNDdWCV3t-KHKGXVPjBCQ@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop> <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <CAPcyv4jqKmnkL1CfHVccHvocmSD4PamqOy4bPsO1789D+107FQ@mail.gmail.com>
 <20180106183937.vkseldf4arkdlkum@ast-mbp> <CAPcyv4hyRfPhnnS=aDf=jMMP+-EJM3ojPC0gX9ChawT3vidkJQ@mail.gmail.com>
 <20180106192517.ykvlcq4564cqy4u6@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106192517.ykvlcq4564cqy4u6@ast-mbp>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 6, 2018 at 11:25 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Sat, Jan 06, 2018 at 10:54:27AM -0800, Dan Williams wrote:
>> On Sat, Jan 6, 2018 at 10:39 AM, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> [..]
>> >> retpoline is variant-2, this patch series is about variant-1.
>> >
>> > that's exactly the point. Don't slow down the kernel with lfences
>> > to solve variant 1. retpoline for 2 is ok from long term kernel
>> > viability perspective.
>> >
>>
>> Setting aside that we still need to measure the impact of these
>> changes the end result will still be nospec_array_ptr() sprinkled in
>> various locations. So can we save the debate about what's inside that
>> macro on various architectures and at least proceed with annotating
>> the problematic locations? Perhaps we can go a step further and have a
>> config option to switch between the clever array_access() approach
>> from Linus that might be fine depending on the compiler, and the
>> cpu-vendor-recommended not to speculate implementation of
>> nospec_array_ptr().
>
> recommended by panicing vendors who had no better ideas?
> Ohh, speculation is exploitable, let's stop speculation.
> Instead of fighting it we can safely steer it where it doesn't leak
> kernel data. AND approach is doing exactly that.
> It probably can be made independent of compiler choice to use setbe-like insn.

Right, when that 'probably' is 'certainly' for the architecture you
care about just update the nospec_array_ptr() definition at that
point.
