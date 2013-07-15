From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH, re-send] Always trap on BUG()
Date: Mon, 15 Jul 2013 15:35:16 -0700
Message-ID: <51E47924.9030005@zytor.com>
References: <201307051738.35930.arnd@arndb.de>
 <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org>
 <20130715222755.GY24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130715222755.GY24642@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chen Gang <gang.chen@asianux.com>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 07/15/2013 03:27 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 15, 2013 at 03:16:12PM -0700, Andrew Morton wrote:
>> I've been thinking for a while that CONFIG_BUG=n is a pretty dumb thing
>> to do, and that maintaining it (and trying to fix the warnings it
>> produces) aren't worth the effort and that we should remove the whole
>> thing.  Perhaps your patch changes that calculus, dunno.  Please discuss.
> 
> This isn't about introducing "CONFIG_BUG=n" - this is about making a
> kernel with CONFIG_BUG=n build without producing tonnes and tonnes of
> warnings, as it does today.  It makes building randconfig pretty
> useless to find what could be more important warnings.
> 

Well, there are three alternatives here, right:

1. We can use unreachable(), which means that the compiler can assume it
never happens.

2. We can trap without metadata.

3. We can trap with metadata (current CONFIG_BUG=y).

I am *guessing* this does 2, but it isn't clear.

	-hpa
