From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH 1/2] compat ABI: use non-compat openat and
 open_by_handle_at variants
Date: Mon, 28 Dec 2015 12:57:56 -0500
Message-ID: <56817824.8020609@ezchip.com>
References: <1451146000-5646-1-git-send-email-ynorov@caviumnetworks.com>
 <1451146000-5646-2-git-send-email-ynorov@caviumnetworks.com>
 <5945276.2UuG1prsU3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5945276.2UuG1prsU3@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, klimov.linux@gmail.com
List-Id: linux-arch.vger.kernel.org

On 12/28/2015 06:18 AM, Arnd Bergmann wrote:
> On Saturday 26 December 2015 19:06:39 Yury Norov wrote:
>> >The only difference is that non-compat version forces O_LARGEFILE,
>> >and it should be the default behaviour for all architectures, as
>> >we don't support 32-bit off_t. The only exception is tile32, that
>> >continues with compat version of syscalls.
>> >
>> >Signed-off-by: Yury Norov<ynorov@caviumnetworks.com>
> Looks good,
>
> Acked-by: Arnd Bergmann<arnd@arndb.de>
>
> (adding Chris to Cc a well, in case he has further comments)

Seems plausible.

Acked-by: Chris Metcalf <cmetcalf@ezchip.com> [for tile]

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
