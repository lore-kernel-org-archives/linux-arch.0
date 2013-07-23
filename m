From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH, re-send] Always trap on BUG()
Date: Tue, 23 Jul 2013 02:54:06 -0700
Message-ID: <51EE52BE.5080204@zytor.com>
References: <201307051738.35930.arnd@arndb.de>
 <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org>
 <20130715222755.GY24642@n2100.arm.linux.org.uk> <51E47924.9030005@zytor.com>
 <20130723093628.GC19786@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130723093628.GC19786@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Chen Gang <gang.chen@asianux.com>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 07/23/2013 02:36 AM, Ingo Molnar wrote:
>>
>> Well, there are three alternatives here, right:
>>
>> 1. We can use unreachable(), which means that the compiler can assume it
>> never happens.
> 
> AFAICS this is dangerous as it loses warnings and moves execution into 
> la-la-land without any obvious sign at the C level.
> 

Extremely dangerous.

	-hpa
