From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 24/40] metag: DMA
Date: Wed, 9 Jan 2013 16:04:53 +0000
Message-ID: <50ED9525.9040806@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <50AF9C06.3010705@imgtec.com> <50AFA24D.4030501@imgtec.com> <201211231647.27260.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201211231647.27260.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 23/11/12 16:47, Arnd Bergmann wrote:
> On Friday 23 November 2012, James Hogan wrote:
>> Subject: [PATCH 1/1] asm-generic/io.h: check CONFIG_VIRT_TO_BUS
>>
>> Make asm-generic/io.h check CONFIG_VIRT_TO_BUS before defining
>> virt_to_bus() and bus_to_virt(), otherwise it's easy to accidentally
>> have a silently failing incorrect direct mapped definition rather then
>> no definition at all.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> 
> Good catch!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Hi Arnd,

Would you like me to include this in the meta patchset or is it okay for
you to take it through the asm-generic tree? (I can resend separately if
you like)

Thanks
James
