From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 13/18] ipv6: prevent bounds-check bypass via speculative execution
Date: Sat, 6 Jan 2018 10:05:44 -0800
Message-ID: <CAPcyv4h_7T_g52R6nL6p=Pcd3en1opPRV4GdN1n9M23hN69xjA@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520106487.32271.6013001625427346680.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180106064852.187637ad@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33695 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeAFSFp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 13:05:45 -0500
Received: by mail-ot0-f196.google.com with SMTP id x15so6365362ote.0
        for <linux-arch@vger.kernel.org>; Sat, 06 Jan 2018 10:05:45 -0800 (PST)
In-Reply-To: <20180106064852.187637ad@xeon-e3>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Netdev <netdev@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Sat, Jan 6, 2018 at 6:48 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Fri, 05 Jan 2018 17:11:04 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> Static analysis reports that 'offset' may be a user controlled value
>> that is used as a data dependency reading from a raw6_frag_vec buffer.
>> In order to avoid potential leaks of kernel memory values, block
>> speculative execution of the instruction stream that could issue further
>> reads based on an invalid '*(rfv->c + offset)' value.
>>
>> Based on an original patch by Elena Reshetova.
>>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
>> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  net/ipv6/raw.c |    9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
>> index 761a473a07c5..384e3d59d148 100644
>> --- a/net/ipv6/raw.c
>> +++ b/net/ipv6/raw.c
>> @@ -33,6 +33,7 @@
>>  #include <linux/skbuff.h>
>>  #include <linux/compat.h>
>>  #include <linux/uaccess.h>
>> +#include <linux/compiler.h>
>>  #include <asm/ioctls.h>
>>
>>  #include <net/net_namespace.h>
>> @@ -725,17 +726,17 @@ static int raw6_getfrag(void *from, char *to, int offset, int len, int odd,
>>                      struct sk_buff *skb)
>>  {
>>       struct raw6_frag_vec *rfv = from;
>> +     char *rfv_buf;
>>
>> -     if (offset < rfv->hlen) {
>> +     if ((rfv_buf = nospec_array_ptr(rfv->c, offset, rfv->hlen))) {
>>               int copy = min(rfv->hlen - offset, len);
>
> Minor nit.
>
> Please don't do assignment in condition test here.
> Instead.
>         rfv_buf = nospec_array_ptr(rfv->c, offset, rfv->hlen);
>         if (rfv_buf) {

Yeah, sorry about that. This was a hold over from an earlier version
where nospec_array_ptr() did not include the necessary barrier and we
relied on a new if_nospec helper, but now that if_nospec is no longer
being proposed I can go back and clean this up.
