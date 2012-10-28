From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 REPOST 2/2] kbuild: run the pre-processor on *.dts files
Date: Sat, 27 Oct 2012 20:06:11 -0500
Message-ID: <fb065651-fd9d-4435-9a61-884dcb1da8d0@email.android.com>
References: <1351279797-16450-1-git-send-email-swarren@wwwdotorg.org>
 <1351279797-16450-2-git-send-email-swarren@wwwdotorg.org>
 <508AEB3E.6090405@gmail.com>
 <20121027220638.GK4564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1750549229080455137=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121027220638.GK4564-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

--===============1750549229080455137==
Content-Type: multipart/alternative; boundary="----QCDDT3S8C7LAY1E4UQ0C3G0KEVSZFN"

------QCDDT3S8C7LAY1E4UQ0C3G0KEVSZFN
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:

>On Fri, Oct 26, 2012 at 02:57:50PM -0500, Rob Herring wrote:
>
>> Like I said previously, I think we first need guidelines on what is
>and
>> isn't acceptable use of C preprocessor in dts files.
>
>Didn't we already say that it was just the same rules as for things tht
>get included in .S files?  Besides for plain .dts files (as opposed to
>.dtsi files) it seems like if people break things they get to keep all
>the pieces without disrupting other people too much.

Yes, but can we document that. Also, I'd like others with more DT histori=
cal knowledge to weigh in.

Rob
------QCDDT3S8C7LAY1E4UQ0C3G0KEVSZFN
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head/><body><html><head></head><body><div class=3D"gmail_quote">Ma=
rk Brown &lt;broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org&gt; wrote:<blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px =
solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style=3D"white-space: pre-wrap; word-wrap:break-word; font-family: m=
onospace; margin-top: 0px">On Fri, Oct 26, 2012 at 02:57:50PM -0500, Rob =
Herring wrote:<br /><br /><blockquote class=3D"gmail_quote" style=3D"marg=
in: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;=
">Like I said previously, I think we first need guidelines on what is and=
<br />isn't acceptable use of C preprocessor in dts files.</blockquote><b=
r />Didn't we already say that it was just the same rules as for things t=
ht<br />get included in .S files?  Besides for plain .dts files (as oppos=
ed to<br />.dtsi files) it seems like if people break things they get to =
keep all<br />the pieces without disrupting other people too much.<br /><=
/pre></blockquote></div><br clear=3D"all">Yes, but can we document that. =
Also, I&#39;d like others with more DT historical knowledge to weigh in.<=
br>
<br>
Rob</body></html></body></html>
------QCDDT3S8C7LAY1E4UQ0C3G0KEVSZFN--


--===============1750549229080455137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1750549229080455137==--
