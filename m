From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 7/8] uapi: export all headers under uapi directories
Date: Mon, 20 Feb 2017 11:14:38 +0100
Message-ID: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
References: <201702022242.toNVsxyq%fengguang.wu@intel.com> <1486724338-5389-1-git-send-email-nicolas.dichtel@6wind.com>
 <1486724338-5389-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170213074931.GA19927@infradead.org> <fc363060-f00d-e9e6-c548-6bfe73665e93@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <fc363060-f00d-e9e6-c548-6bfe73665e93@6wind.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Christoph Hellwig <hch@infradead.org>, Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, bp@alien8.de, Mason <slash.tmp@free.fr>, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, tklauser@distanz.ch, Michael Ellerman <mpe@ellerman.id.au>, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 20, 2017 at 10:32 AM, Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> Le 13/02/2017 =C3=A0 08:49, Christoph Hellwig a =C3=A9crit :
>>> linux/genwqe/..install.cmd
>>> linux/genwqe/.install
>>
>> Third time:  NAK on exporting internal kbuild metadata.
>>
> And for the third time: this is not related to this series. Those files a=
re
> there before my series and the goal of the series has nothing to do with =
that.
>
> Feel free to send a patch.

Your description literally says "After this patch, the following files, whi=
ch
were not exported, are now exported (with make headers_install_all)"
for the files that Christoph quoted. It that is not true, then you need to
update the patch description to say what your patch actually does.

    Arnd
