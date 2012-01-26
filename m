From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] /sys/class/tty/tty0/active?
Date: Thu, 26 Jan 2012 23:56:50 +0100
Message-ID: <CAFLxGvzffs=uSjxogdWtk_gqoJHPnmgQSLw9WaZRr_be=J5cgw@mail.gmail.com>
References: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
	<58311.79.160.186.248.1327615864.squirrel@www.nlc.no>
	<CAFLxGvzsg71gtyPEtOAVnS-DtozYzqgoGNK-ZJRvBfq1mf3Oug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42994 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796Ab2AZW4v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jan 2012 17:56:51 -0500
In-Reply-To: <CAFLxGvzsg71gtyPEtOAVnS-DtozYzqgoGNK-ZJRvBfq1mf3Oug@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: stian@nixia.no
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Greg KH <gregkh@suse.de>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 26, 2012 at 11:12 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Thu, Jan 26, 2012 at 11:11 PM, =A0<stian@nixia.no> wrote:
>>> Hi!
>>>
>>> systemd goes nuts on UML.
>>> While hunting down all issues I found out that systemd wants to rea=
d from
>>> /sys/class/tty/tty0/active.
>>
>> Kernel version?
>
> Linus' tree as of today.

Hmm, fbc92a34 introduced it.
But it depends on CONFIG_VT. :-\

--=20
Thanks,
//richard
