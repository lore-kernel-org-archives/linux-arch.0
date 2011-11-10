From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
Date: Thu, 10 Nov 2011 22:17:42 +0800
Message-ID: <CAM_iQpVT_z++a9G2H5oCPk8uPiSpfqV_eC=7KA+3nedgaNHz7g@mail.gmail.com>
References: <1319639649.3321.11.camel@br98xy6r>
	<20111028161143.e5ebf617.akpm@linux-foundation.org>
	<1320055036.2796.8.camel@br98xy6r>
	<20111031033948.a0edb7f3.akpm@linux-foundation.org>
	<1320314844.2989.6.camel@br98xy6r>
	<20111109160400.cc2d27d9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46742 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934701Ab1KJORm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Nov 2011 09:17:42 -0500
In-Reply-To: <20111109160400.cc2d27d9.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: holzheu@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>, Don Zickus <dzickus@redhat.com>, "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org

On Thu, Nov 10, 2011 at 8:04 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> Ho hum, I guess we stick with the original patch. =C2=A0It *should* w=
ork, as
> long as all archtectures are doing the expected thing. =C2=A0But in t=
his
> situation it is bad of us to just hope that the architectures are doi=
ng
> this. =C2=A0We should go and find out, rather than waiting for bug re=
ports
> to come in. =C2=A0Especially because in this case, bugs will take a v=
ery
> long time indeed to even be noticed.
>
> One way to resolve this would be to ask the various arch maintainers!

At least we can add the spin_lock just for x86 and s390, and leave
a big comment saying we are waiting for the other arch to be fixed...

Thanks.
