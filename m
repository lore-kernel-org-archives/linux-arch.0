From: Noam Camus <noamca@mellanox.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Fri, 11 Mar 2016 05:07:09 +0000
Message-ID: <HE1PR05MB1625869B55C8FB5657477812AAB50@HE1PR05MB1625.eurprd05.prod.outlook.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
 <1457595846.2868.10.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8F1A0@us01wembx1.internal.synopsys.com>,
 <1457636268.457.34.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457636268.457.34.camel@synopsys.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Lada Trimasova <Lada.Trimasova@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

> From: Lada Trimasova <Lada.Trimasova@synopsys.com>
> Sent: Thursday, March 10, 2016 8:57 PM

> And for example, let's see what happens when we use "readl" in  function "serial8250_early_in" in driver/tty/serial/8250.

Is your DTS entry includes for serial node following entries:
reg-io-width = <4>
native-endian;

if answer is yes you should expect (in case of big endian compilation) that:
port->iotype would be equal to UPIO_MEM32BE, hence no readl() use for this case.

This is how it works for me here, it sounds like your case is similar.

Regards,
Noam
