From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 12/27] asm-generic: add a NOMMU uaccess.h
Date: Fri, 01 May 2009 14:38:12 +0200
Message-ID: <49FAED34.5000701@monstr.eu>
References: <cover.1241105648.git.arnd@arndb.de> <45b4644e80c27b9d042b3960e3d99f0d444e0d92.1241105648.git.arnd@arndb.de> <c1a198be0904302337x714621d8xc4685a634c5cf222@mail.gmail.com> <200905011436.05204.arnd@arndb.de>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760245AbZEAMim@vger.kernel.org>
In-Reply-To: <200905011436.05204.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann wrote:
> On Friday 01 May 2009, Michal Simek wrote:
>>> +#ifndef __put_user
>>> +#define __put_user(x, ptr)                             \
>>> +({                                                     \
>>> +       int __pu_err = 0;                               \
>>> +       typeof(*(ptr)) __pu_val = (x);                  \
>>> +       switch (sizeof (*(ptr))) {                      \
>>> +       case 1:                                         \
>>> +       case 2:                                         \
>>> +       case 4:                                         \
>>> +               *(ptr) = (__pu_val);                    \
>>> +               break;                                  \
>>> +       case 8:                                         \
>>> +               memcpy(ptr, &__pu_val, sizeof (*(ptr)));\
>>
>> potential cast problem
> 
> Yes, I'm looking into this already, probably will do something
> based on the s390 code, which seems to do this correctly.
> 
>>> +#define put_user(x, ptr) (                             \
>>> +       access_ok(VERIFY_WRITE, ptr, sizeof (*ptr)) ?   \
>>> +               __put_user(x, ptr) :                    \
>>> +               -EFAULT)
>>
>> IMHO write it as inline function with type checking.
> 
> Unfortunately, this doesn't work because of the callin
> conventions: __put_user needs to know the type of ptr,
> so it has to be a macro.

yes, I am looking on it too.

Michal

> 
> 	Arnd <><


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
