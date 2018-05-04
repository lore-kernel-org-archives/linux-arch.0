From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Introducing a nanoMIPS port for Linux
Date: Fri, 4 May 2018 19:53:04 -0400
Message-ID: <CAK8P3a1BvG+jHAmQu2j-_Gmmxc4s_KbccUGP0jvPGq6L+vtjdw@mail.gmail.com>
References: <20180502215107.GA9884@saruman> <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
 <20180504132432.GA30458@jamesdev>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504132432.GA30458@jamesdev>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Matt Redfearn <matt.redfearn@mips.com>, Marcin Nowakowski <marcin.nowakowski@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>
List-Id: linux-arch.vger.kernel.org

On Fri, May 4, 2018 at 9:24 AM, James Hogan <jhogan@kernel.org> wrote:
> On Thu, May 03, 2018 at 06:40:07PM -0400, Arnd Bergmann wrote:
>> On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:
>>
>> While I haven't looked at the individual changes, I wonder whether
>> it would be useful to make this new ABI use 64-bit time_t from
>> the start, using the new system calls that Deepa and I have been
>> posting recently.
>
> Personally I'm all for squeezing as much API cleanup in as possible
> before its merged, though obviously there'll be a point when the ABI may
> need to be frozen, at which point we'll mostly have to accept what we
> have within reason.
>
>> There are still a few things to be worked out:
>> only the first of four sets of syscall patches is merged so far,
>> and we have a couple of areas that will require further ABI changes
>> (sound, sockets, media and maybe a couple of smaller drivers),
>> so it depends on the overall timing. If you would otherwise merge
>> the patches quickly, then it may be better to just follow the existing
>> 32-bit architectures and add the 64-bit entry points when we do it
>> for everyone.
>
> I think it'll likely be a couple of cycles before it gets merged anyway.
> There's still work to do, and limited resources.

Ok, let's plan on getting the 64-bit time_t ABIs in place early enough
then. We will likely have very similar timing for the upcoming rv32
ABI on arch/riscv.

         Arnd
