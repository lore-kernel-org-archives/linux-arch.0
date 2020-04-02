From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Date: Thu, 2 Apr 2020 20:35:09 +0200
Message-ID: <24095989-57be-332c-f08c-acb1672c7e6f@c-s.fr>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:12271 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgDBSfM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Apr 2020 14:35:12 -0400
In-Reply-To: <20200402175032.GH23230@ZenIV.linux.org.uk>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, akpm@linux-foundation.org, keescook@chromium.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>



Le 02/04/2020 à 19:50, Al Viro a écrit :
> On Thu, Apr 02, 2020 at 07:03:28PM +0200, Christophe Leroy wrote:
> 
>> user_access_begin() grants both read and write.
>>
>> This patch adds user_read_access_begin() and user_write_access_begin() but
>> it doesn't remove user_access_begin()
> 
> Ouch...  So the most generic name is for the rarest case?
>   

I can add another patch at the end of the series to rename 
user_access_begin() to user_full_access_begin().

Would it suit you ?

Christophe
