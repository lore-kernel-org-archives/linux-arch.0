From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 35/57] media: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 15:02:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109211501440.2723@ionos>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-36-git-send-email-yong.zhang0@gmail.com>
	<4E79DF04.8060209@infradead.org>
Reply-To: MJPEG-tools user list <mjpeg-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <mjpeg-users-bounces@lists.sourceforge.net>
In-Reply-To: <4E79DF04.8060209@infradead.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mjpeg-users>,
	<mailto:mjpeg-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=mjpeg-users>
List-Post: <mailto:mjpeg-users@lists.sourceforge.net>
List-Help: <mailto:mjpeg-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mjpeg-users>,
	<mailto:mjpeg-users-request@lists.sourceforge.net?subject=subscribe>
Errors-To: mjpeg-users-bounces@lists.sourceforge.net
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Kamil Debski <k.debski@samsung.com>, =?ISO-8859-15?Q?David_H=E4rdeman?= <david@hardeman.nu>, Wolfram Sang <w.sang@pengutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Igor M. Liplianin" <liplianin@netup.ru>, linux-arch@vger.kernel.org, Lawrence Rust <lawrence@softsystem.co.uk>, Mats Randgaard <mats.randgaard@cisco.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Jarod Wilson <jarod@redhat.com>, Muralidharan Karicheri <m-karicheri2@ti.com>, Istvan Varga <istvan_v@mailbox.hu>, Hans Verkuil <hans.verkuil@cisco.com>, Jean Delvare <khali@linux-fr.org>, linux-media@vger.kernel.org, Lucas De Marchi <lucas.demarchi@profusion.mobi>, ivtv-devel@ivtvdriver.org, Jonathan Nieder <jrnieder@gmail.com>, Yong Zhang <yong.zhang0@gmail.com>, mjpeg-users@lists.sourceforge.net, Andy Walls <awalls@md.metrocast.net>, Devin
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Sep 2011, Mauro Carvalho Chehab wrote:

> Em 21-09-2011 06:28, Yong Zhang escreveu:
> > Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> > We run all interrupt handlers with interrupts disabled
> > and we even check and yell when an interrupt handler
> > returns with interrupts enabled (see commit [b738a50a:
> > genirq: Warn when handler enables interrupts]).
> > 
> > So now this flag is a NOOP and can be removed.
> > 
> > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> Not sure if you want to send this patch directly or via
> the linux-media tree. If you want to send it directly:
> 
> Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>
> 
> If not, please let me know, and I'll apply it on my tree
> with my SOB.

Please take it, I collect the leftovers.

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
