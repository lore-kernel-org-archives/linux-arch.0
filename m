From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 49/73] drivers/mtd: delete non-required instances of
 include <linux/init.h>
Date: Wed, 29 Jan 2014 09:34:40 -0500
Message-ID: <52E91180.9080807@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-50-git-send-email-paul.gortmaker@windriver.com>
 <20140129000216.GB8919@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20140129000216.GB8919@ld-irv-0074>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 14-01-28 07:02 PM, Brian Norris wrote:
> On Tue, Jan 21, 2014 at 04:22:52PM -0500, Paul Gortmaker wrote:
>> None of these files are actually using any __init type directives
>> and hence don't need to include <linux/init.h>.  Most are just a
>> left over from __devinit and __cpuinit removal, or simply due to
>> code getting copied from one driver to the next.
>>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Brian Norris <computersforpeace@gmail.com>
>> Cc: linux-mtd@lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
>> diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
>> index 8fc06bf..3428034e 100644
>> --- a/drivers/mtd/maps/sa1100-flash.c
>> +++ b/drivers/mtd/maps/sa1100-flash.c
>> @@ -7,7 +7,6 @@
>>  #include <linux/types.h>
>>  #include <linux/ioport.h>
>>  #include <linux/kernel.h>
>> -#include <linux/init.h>
>>  #include <linux/errno.h>
>>  #include <linux/slab.h>
>>  #include <linux/platform_device.h>
> 
> This file uses __exit_p(), from <linux/init.h>. So I dropped this hunk
> and pushed the rest to l2-mtd.git/next.

Thanks!  Not sure why that got caught up in the review, since I had __exit
in my regex filter. It had module.h so I never caught the false positive in
my build testing either.

Paul.
--
> 
> Thanks,
> Brian
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
