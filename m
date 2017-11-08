From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 00/31] Andes(nds32) Linux Kernel Port
Date: Wed, 8 Nov 2017 16:41:06 +0800
Message-ID: <CAEbi=3djUeMtRniq0Z98tVZw_QXB7hfS_mubrot3zHyTjvWZ9A@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <7795.1510129943@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7795.1510129943@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev <netdev@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2017-11-08 16:32 GMT+08:00 David Howells <dhowells@redhat.com>:
> Greentime Hu <green.hu@gmail.com> wrote:
>
>> The build script and toolchain repositories are able to be found here:
>>   https://github.com/andestech/build_script.git
>
> Is arch support in upstream binutils and gcc?

Yes, it is but only supporting elf-toolchain now. We will do the
upstream for Linux-toolchain in the next step.
