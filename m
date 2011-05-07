From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 7/7] ns: Wire up the setns system call
Date: Sat, 7 May 2011 09:59:12 -0400
Message-ID: <BANLkTikmvyBZn7iOiSpX3vf7v11nP7N19g@mail.gmail.com>
References: <m1tyd7p7tq.fsf@fess.ebiederm.org> <1304735101-1824-1-git-send-email-ebiederm@xmission.com>
 <1304735101-1824-7-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65473 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab1EGN7d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 09:59:33 -0400
In-Reply-To: <1304735101-1824-7-git-send-email-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, jamal <hadi@cyberus.ca>, Daniel Lezcano <daniel.lezcano@free.fr>, Linux Containers <containers@lists.osdl.org>, Renato Westphal <renatowestphal@gmail.com>

On Fri, May 6, 2011 at 22:25, Eric W. Biederman wrote:
> v2: Most of the architecture support added by Daniel Lezcano <dlezcan=
o@fr.ibm.com>
> v3: ported to v2.6.36-rc4 by: Eric W. Biederman <ebiederm@xmission.co=
m>
> v4: Moved wiring up of the system call to another patch
> v5: ported to v2.6.39-rc6
>
> =C2=A0arch/blackfin/include/asm/unistd.h =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
3 ++-
> =C2=A0arch/blackfin/mach-common/entry.S =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
=C2=A01 +

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
