From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [uml-devel] /sys/class/tty/tty0/active?
Date: Fri, 27 Jan 2012 02:30:33 +0100
Message-ID: <CAPXgP12Bj1K3j5HL1=GTj=xEC+oWgB7VFeQL_Pg23fCevTQAcw@mail.gmail.com>
References: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
 <58311.79.160.186.248.1327615864.squirrel@www.nlc.no> <CAFLxGvzsg71gtyPEtOAVnS-DtozYzqgoGNK-ZJRvBfq1mf3Oug@mail.gmail.com>
 <CAFLxGvzffs=uSjxogdWtk_gqoJHPnmgQSLw9WaZRr_be=J5cgw@mail.gmail.com> <20120127010838.GA27899@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120127010838.GA27899@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, stian@nixia.no, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 27, 2012 at 02:08, Greg KH <gregkh@suse.de> wrote:
> On Thu, Jan 26, 2012 at 11:56:50PM +0100, richard -rw- weinberger wro=
te:
>> On Thu, Jan 26, 2012 at 11:12 PM, richard -rw- weinberger
>> <richard.weinberger@gmail.com> wrote:
>> > On Thu, Jan 26, 2012 at 11:11 PM, =C2=A0<stian@nixia.no> wrote:
>> >>> Hi!
>> >>>
>> >>> systemd goes nuts on UML.
>> >>> While hunting down all issues I found out that systemd wants to =
read from
>> >>> /sys/class/tty/tty0/active.
>> >>
>> >> Kernel version?
>> >
>> > Linus' tree as of today.
>>
>> Hmm, fbc92a34 introduced it.
>> But it depends on CONFIG_VT. :-\
>
> Is that a problem for UML somehow?

In general, the "crippled" environments might not really the right
thing too run full-blown user login managers like logind.

The main systemd 'init' will not have any problems with that, but
running logind might not really work out under UML.

Depending how far full-OS support in UML should go, logind should
either not run inside UML, or if, UML should provide the needed bits
for in virtual consoles.

If it is not to be solved otherwise, maybe logind needs more
VT-avoiding logic like this:
  http://cgit.freedesktop.org/systemd/systemd/commit/?id=3Daddedec48ba0=
ffc4472ef6d3b5a45c9d4239f1cd

Kay
