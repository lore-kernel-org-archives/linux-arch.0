From: Daniel Mack <zonque@gmail.com>
Subject: Re: [revert request for commit 9fff2fa] Re: [git pull] signals pile 3
Date: Sun, 14 Oct 2012 18:44:12 +0200
Message-ID: <CACTFLAOpcLtHNx-TCHQkUOPNAkTO8EgDhbyZSGQ9ag+Wu_cNRw@mail.gmail.com>
References: <20121013005334.GM2616@ZenIV.linux.org.uk>
 <507ADBBB.9090209@gmail.com>
 <20121014164020.GV2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8673905480420071397=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121014164020.GV2616@ZenIV.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

--===============8673905480420071397==
Content-Type: multipart/alternative; boundary=20cf3074b14a790d6b04cc07a1d0

--20cf3074b14a790d6b04cc07a1d0
Content-Type: text/plain; charset=ISO-8859-1

On Oct 14, 2012 6:40 PM, "Al Viro" <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Oct 14, 2012 at 05:35:23PM +0200, Daniel Mack wrote:
>
> > I rebased my ARM development branch and figured that your patch 9fff2fa
> > ("arm: switch to saner kernel_execve() semantics") breaks the boot on my
> > board right after init is invoked via NFS:
>
> OK, revert it is, then.  Nothing in the tree has dependencies on that
sucker
> and while it survives testing here, it's obviously not ready for mainline.
> So, with abject apologies to everyone involved, please revert.

Reverting it is not straight forward, and half of this patch doesn't seem
to cause issues.

I can resend my patch with an S-o-b if you want me to.

--20cf3074b14a790d6b04cc07a1d0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Oct 14, 2012 6:40 PM, &quot;Al Viro&quot; &lt;<a href=3D"mailto:viro@zen=
iv.linux.org.uk">viro@zeniv.linux.org.uk</a>&gt; wrote:<br>
&gt;<br>
&gt; On Sun, Oct 14, 2012 at 05:35:23PM +0200, Daniel Mack wrote:<br>
&gt;<br>
&gt; &gt; I rebased my ARM development branch and figured that your patch 9=
fff2fa<br>
&gt; &gt; (&quot;arm: switch to saner kernel_execve() semantics&quot;) brea=
ks the boot on my<br>
&gt; &gt; board right after init is invoked via NFS:<br>
&gt;<br>
&gt; OK, revert it is, then. =A0Nothing in the tree has dependencies on tha=
t sucker<br>
&gt; and while it survives testing here, it&#39;s obviously not ready for m=
ainline.<br>
&gt; So, with abject apologies to everyone involved, please revert.</p>
<p>Reverting it is not straight forward, and half of this patch doesn&#39;t=
 seem to cause issues.</p>
<p>I can resend my patch with an S-o-b if you want me to.</p>

--20cf3074b14a790d6b04cc07a1d0--


--===============8673905480420071397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8673905480420071397==--
