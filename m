From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 31/31] ARC: [plat-arcfpga] defconfig
Date: Mon, 12 Nov 2012 14:18:40 +0000
Message-ID: <50A10540.3080005@imgtec.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-32-git-send-email-vgupta@synopsys.com> <201211071406.58304.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:51629 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab2KLOSn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Nov 2012 09:18:43 -0500
In-Reply-To: <201211071406.58304.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On 07/11/12 14:06, Arnd Bergmann wrote:
> On Wednesday 07 November 2012, Vineet Gupta wrote:
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>> ---
>>  arch/arc/configs/fpga_defconfig |  607 +++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 607 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arc/configs/fpga_defconfig
>>
>> diff --git a/arch/arc/configs/fpga_defconfig b/arch/arc/configs/fpga_defconfig
>> new file mode 100644
>> index 0000000..cfdca3c
>> --- /dev/null
>> +++ b/arch/arc/configs/fpga_defconfig
>> @@ -0,0 +1,607 @@
>> +#
>> +# Automatically generated file; DO NOT EDIT.
>> +# Linux/arc 3.7.0-rc3 Kernel Configuration
>> +#
> 
> Please use "make defconfig" to generate minimal defconfig files, instead of
> copying the entire file here.

Hi Arnd,

I think you mean "make savedefconfig"? (I think "make defconfig" loads
the default defconfig).

Cheers
James
