From: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
Date: Tue, 20 Mar 2018 10:11:47 -0700 (PDT)
Message-ID: <mhng-f6731cb9-8394-419d-b14b-c6fcd6c0930d@palmer-si-x1c4>
References: <CAK8P3a01pfvsdM1mR8raU9dA7p4H-jRJz2Y8-+KEY76W_Mukpg@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a01pfvsdM1mR8raU9dA7p4H-jRJz2Y8-+KEY76W_Mukpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: hare-l3A5Bk7waGM@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Thu, 15 Mar 2018 03:42:25 PDT (-0700), Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 10:59 AM, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org> wrote:
>> On 03/15/2018 10:42 AM, David Howells wrote:
>>> Do we have anything left that still implements NOMMU?
>>>
>> RISC-V ?
>> (evil grin :-)
>
> Is anyone producing a chip that includes enough of the Privileged ISA spec
> to have things like system calls, but not the MMU parts?
>
> I thought at least initially the kernel only supports hardware that has a rather
> complete feature set.

We currently do not have a NOMMU port.  As far as I know, everyone who's
currently producing RISC-V hardware with enough memory to run Linux has S mode
with paging support.  The ISA allows for S mode without paging but there's no
hardware for that -- if you're going to put a DRAM controller on there then
paging seems pretty cheap.  You could run a NOMMU port on a system with S-mode
and paging, but With all the superpage stuff I don't think you'll get an
appreciable performance win for any workload running without an MMU so there's
nothing to justify the work (and incompatibility) of a NOMMU port there.

While I think you could implement a NOMMU port on a machine with only M and U
modes (and therefor no address translation at all), I don't know of any MU-only
machines that have enough memory to run Linux (ours have less than 32KiB).  A
SBI-free Linux would be a prerequisite for this, but there's some interest in
that outside of a NOMMU port so it might materialize anyway.

Of course, QEMU could probably be tricked into emulating one of these machines
with little to no effort :)...  That said, I doubt we'll see a NOMMU port
materialize without some real hardware as it's a lot of work for a QEMU-only
target.
