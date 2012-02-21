From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/30] compat: Use COMPAT_USE_64BIT_TIME in the Bluetooth
 subsystem
Date: Tue, 21 Feb 2012 11:15:09 -0800
Message-ID: <4F43ED3D.20504@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <1329696488-16970-11-git-send-email-hpa@zytor.com> <20120221190419.GA2914@joana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120221190419.GA2914@joana>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On 02/21/2012 11:05 AM, Gustavo Padovan wrote:
> 
> * H. Peter Anvin <hpa@zytor.com> [2012-02-19 16:07:48 -0800]:
> 
>> From: "H. J. Lu" <hjl.tools@gmail.com>
>>
>> Enable the Bluetooth subsystem to be used with a compat ABI with
>> 64-bit time.
>>
>> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: Gustavo F. Padovan <padovan@profusion.mobi>
>> Cc: David S. Miller <davem@davemloft.net>
>> ---
>>  net/bluetooth/hci_sock.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> Applied, thanks.
> 

OK, I have it in my x86/x32 tree; you don't want to have this patch
without the prior patch for obvious reasons.

	-hpa
