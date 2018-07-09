From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Date: Mon, 9 Jul 2018 10:23:58 +0000
Message-ID: <82d2b36fa913bca6d56c7bf32a653324970817b8.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
 <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
 <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
 <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
Content-Language: en-US
Content-ID: <0FE62AD68A7BDD4BA7A10A97E9CFE6D3@internal.synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi David,

On Mon, 2018-07-09 at 10:18 +0000, David Laight wrote:
> From: Alexey Brodkin
> > Sent: 09 July 2018 11:00
> 
> ...
> > That's a good idea indeed but it doesn't solve the problem with
> > struct devres_node. Consider the following snippet:
> > -------------------------------->8-------------------------------
> > 	struct mystruct {
> > 		atomic64_t myvar;
> > 	}
> > 
> > 	struct mystruct *p;
> > 	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
> > -------------------------------->8-------------------------------
> > 
> > Here myvar address will match address of "data" member of struct devres_node.
> > So if "data" is has offset of 12 bytes from the beginning of a page then
> > myvar won't be 64-bit aligned regardless of myvar's attribute, right?
> 
> ...
> > > > -	unsigned long long		data[];	/* guarantee ull alignment */
> 
> Ahh, that line should be:
> 	u8 data[] __aligned(8); /* Guarantee 64bit alignment */

And that pretty much what I suggested in my initial patch :)

For the record x86 has exactly the same atomic64_t as you suggested,
see https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/atomic64_32.h#L13:
---------------------->8------------------
typedef struct {
	u64 __aligned(8) counter;
} atomic64_t;
---------------------->8------------------

-Alexey
