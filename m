From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH v2 23/40] tile: enable sparse checks for get/put_user
Date: Tue, 13 Jan 2015 10:55:26 -0500
Message-ID: <54B53FEE.2090903@ezchip.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com> <1420558883-10131-24-git-send-email-mst@redhat.com> <54B46204.1010003@ezchip.com> <20150113094554.GB4434@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0068.outbound.protection.outlook.com ([157.55.234.68]:7403
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752603AbbAMPzq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Jan 2015 10:55:46 -0500
In-Reply-To: <20150113094554.GB4434@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On 1/13/2015 4:45 AM, Michael S. Tsirkin wrote:
> On Mon, Jan 12, 2015 at 07:08:36PM -0500, Chris Metcalf wrote:
>> The key changes are to copy the x86 definition of __inttype(), and then to
>> arrange to use an intermediate integral type that gets assigned to or from
>> the actual typed value so as to expose any sparse issues.
>>
>> If this works for you, I'm happy to queue it in the tile tree, or I can
>> provide a proper git commit for you to include in your series, whichever
>> works better for you.
> Please queue it up for 3.20. Extra __force is needed in a couple of
> places - would you like to fix this up yourself, or do you want me to
> write a patch on top?

I'll fold in your suggestions to my patch.

>> @@ -178,7 +178,7 @@ extern int fixup_exception(struct pt_regs *regs);
>>                               "9:"                                       \
>>                               : "=r" (ret), "=r" (__a), "=&r" (__b)      \
>>                               : "r" (ptr), "i" (-EFAULT));               \
>> -               (x) = (__typeof(x))(__typeof((x)-(x)))                  \
>> +               (x) = (__typeof(x))(__inttype(x))                       \
>>                          (((u64)__hi32(__a, __b) << 32) |                \
>>                           __lo32(__a, __b));                             \
>>          })
> This cast to __typeof(x) needs to be done with __force, otherwise
> there will be a warning with bitwise types.

Actually, this place no longer needs any casting at all, on reflection.
I've changed the __get_user() code to do the "get" into an __inttype
uniformly, so __get_user_8 will always have a u64 type for "x" here.

I'll cc you on the updated patch, so if you'd like to add your
Reviewed-by tag to it, let me know.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
