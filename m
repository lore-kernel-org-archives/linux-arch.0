From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RESEND PATCH v2 9/9] ath5k: Constify ioreadX() iomem argument
 (as in generic implementation)
Date: Mon, 24 Feb 2020 13:47:44 +0100
Message-ID: <20200224124744.GA1949@pi3>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-10-krzk@kernel.org>
 <518a9023-f802-17b3-fca5-582400bc34ae@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <518a9023-f802-17b3-fca5-582400bc34ae@gmail.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kall
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 20, 2020 at 10:48:33AM +0100, Jiri Slaby wrote:
> On 19. 02. 20, 18:50, Krzysztof Kozlowski wrote:
> > The ioreadX() helpers have inconsistent interface.  On some architectures
> > void *__iomem address argument is a pointer to const, on some not.
> > 
> > Implementations of ioreadX() do not modify the memory under the address
> > so they can be converted to a "const" version for const-safety and
> > consistency among architectures.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Kalle Valo <kvalo@codeaurora.org>
> > ---
> >  drivers/net/wireless/ath/ath5k/ahb.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
> > index 2c9cec8b53d9..8bd01df369fb 100644
> > --- a/drivers/net/wireless/ath/ath5k/ahb.c
> > +++ b/drivers/net/wireless/ath/ath5k/ahb.c
> > @@ -138,18 +138,18 @@ static int ath_ahb_probe(struct platform_device *pdev)
> >  
> >  	if (bcfg->devid >= AR5K_SREV_AR2315_R6) {
> >  		/* Enable WMAC AHB arbitration */
> > -		reg = ioread32((void __iomem *) AR5K_AR2315_AHB_ARB_CTL);
> > +		reg = ioread32((const void __iomem *) AR5K_AR2315_AHB_ARB_CTL);
> 
> While I understand why the parameter of ioread32 should be const, I
> don't see a reason for these casts on the users' side. What does it
> bring except longer code to read?

Because the argument is an int:

drivers/net/wireless/ath/ath5k/ahb.c: In function ‘ath_ahb_probe’:
drivers/net/wireless/ath/ath5k/ahb.c:141:18: warning: passing argument 1 of ‘ioread32’ makes pointer from integer without a cast [-Wint-conversion]
   reg = ioread32(AR5K_AR2315_AHB_ARB_CTL);

Best regards,
Krzysztof
