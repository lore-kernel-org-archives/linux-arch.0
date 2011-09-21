From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [PATCH 35/57] media: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 20:13:25 +0800
Message-ID: <20110921121325.GD2550@zhy>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-36-git-send-email-yong.zhang0@gmail.com>
	<20110921102737.GA1966@pengutronix.de>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>,
	MJPEG-tools user list <mjpeg-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <mjpeg-users-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20110921102737.GA1966@pengutronix.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mjpeg-users>,
	<mailto:mjpeg-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=mjpeg-users>
List-Post: <mailto:mjpeg-users@lists.sourceforge.net>
List-Help: <mailto:mjpeg-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mjpeg-users>,
	<mailto:mjpeg-users-request@lists.sourceforge.net?subject=subscribe>
Errors-To: mjpeg-users-bounces@lists.sourceforge.net
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Kamil Debski <k.debski@samsung.com>, David =?utf-8?Q?H=EF=BF=BDrdeman?= <david@hardeman.nu>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Igor M. Liplianin" <liplianin@netup.ru>, linux-arch@vger.kernel.org, Mats Randgaard <mats.randgaard@cisco.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Jarod Wilson <jarod@redhat.com>, Muralidharan Karicheri <m-karicheri2@ti.com>, Istvan Varga <istvan_v@mailbox.hu>, Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org, Lucas De Marchi <lucas.demarchi@profusion.mobi>, ivtv-devel@ivtvdriver.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Jonathan Nieder <jrnieder@gmail.com>, Jean Delvare <khali@linux-fr.org>, mjpeg-users@lists.sourceforge.net, tglx@linutronix.de, Andy Walls <awalls@md.metrocast.net>, Devin Heitmueller <dheitmueller@ker>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 21, 2011 at 12:27:37PM +0200, Wolfram Sang wrote:
> On Wed, Sep 21, 2011 at 05:28:36PM +0800, Yong Zhang wrote:
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
> Umm, I didn't ack this patch but the MTD one :) Nevermind, I had a look
> here as well and it looks okay, so you can keep the ack.

Sorry and thanks :)

	Yong
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |



------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
