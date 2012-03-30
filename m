From: Michal Simek <michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>
Subject: Re: [microblaze-linux] [PATCH 17/38] Disintegrate asm/system.h for Microblaze [ver #3]
Date: Fri, 30 Mar 2012 11:58:22 +0200
Message-ID: <CAE=Ag5==ZSdQR4VtWyNVRu4NrM2B55WL5sukA8AVKmNLvd1F-Q@mail.gmail.com>
References: <20120315205514.28759.58969.stgit@warthog.procyon.org.uk>
	<20120315205754.28759.56543.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1943313747=="
Return-path: <microblaze-linux-bounces-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org>
In-Reply-To: <20120315205754.28759.56543.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux>,
	<mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.eait.uq.edu.au/pipermail/microblaze-linux>
List-Post: <mailto:microblaze-linux-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org>
List-Help: <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=help>
List-Subscribe: <https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux>,
	<mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=subscribe>
Errors-To: microblaze-linux-bounces-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org

--===============1943313747==
Content-Type: multipart/alternative; boundary="001636eee35a84362c04bc72e1fb"

--001636eee35a84362c04bc72e1fb
Content-Type: text/plain; charset="ISO-8859-1"

HI David,

On 15 March 2012 21:57, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Disintegrate asm/system.h for Microblaze.  Not compiled.
>
> Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
>

There are two compilation errors. I have created patch to fix it. Will add
it to mainline through
my microblaze repo.
Next time please copy directly me <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org> instead of mailng list.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

--001636eee35a84362c04bc72e1fb
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

HI David,<br><br><div class=3D"gmail_quote">On 15 March 2012 21:57, David H=
owells <span dir=3D"ltr">&lt;<a href=3D"mailto:dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">dhowell=
s@redhat.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
Disintegrate asm/system.h for Microblaze. =A0Not compiled.<br>
<br>
Signed-off-by: David Howells &lt;<a href=3D"mailto:dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">dho=
wells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
cc: <a href=3D"mailto:microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org">microblaze-uclinux=
@itee.uq.edu.au</a><br></blockquote></div><br>There are two compilation err=
ors. I have created patch to fix it. Will add it to mainline through<br>
my microblaze repo. <br>Next time please copy directly me &lt;<a href=3D"ma=
ilto:monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org">monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org</a>&gt; instead of mailng list.<br>=
<br>Thanks,<br>Michal<br><br>-- <br>Michal Simek, Ing. (M.Eng)<br>PetaLogix=
 - Linux Solutions for a Reconfigurable World<br>
w: <a href=3D"http://www.petalogix.com">www.petalogix.com</a> p: +61-7-3009=
0663,+42-0-721842854 f: +61-7-30090663<br>

--001636eee35a84362c04bc72e1fb--

--===============1943313747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
microblaze-linux mailing list
microblaze-linux-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org
https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux

--===============1943313747==--
