From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
Date: Tue, 8 May 2012 10:39:03 -0700
Message-ID: <CA+8MBbJHH1niHHR7md844UwphmeYczYQBJOB3huGFaxU9AXMTA@mail.gmail.com>
References: <20120428205651.GA7426@merkur.ravnborg.org>
	<20120428205919.GC7442@merkur.ravnborg.org>
	<4FA460AB.6060309@suse.cz>
	<20120505082916.GA14006@merkur.ravnborg.org>
	<CA+8MBbKd9zAouJy5JvUnLwUHMJ65HsYgCTfBgv42nm32EnMPFA@mail.gmail.com>
	<20120508165118.GA11750@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20120508165118.GA11750@merkur.ravnborg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Marek <mmarek@suse.cz>, linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>
List-Id: linux-arch.vger.kernel.org

On Tue, May 8, 2012 at 9:51 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> - =A0 =A0 =A0 local aflags=3D"${KBUILD_AFLAGS} ${NOSTDINC_FLAGS} =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${LINUXINCLUDE} ${KBUILD_CP=
PFLAGS}"
> + =A0 =A0 =A0 local aflags=3D"${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL=
} =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${NOSTDINC_FLAGS} ${LINUXIN=
CLUDE} ${KBUILD_CPPFLAGS}"

Heh. When I first got in this morning your e-mail hadn't arrived yet.
So I ran some make V=3D1 on the old and latest tree and saw the problem
was missing KBUILD_AFLAGS_KERNEL. I was just about to send this
exact patch to you.

So yes ... it works.

Tested-by: Tony Luck <tony.luck@intel.com>

Thanks

-Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
