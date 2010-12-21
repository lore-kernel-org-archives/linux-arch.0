From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 1/4] of: Add support for linking device tree blobs into
 vmlinux
Date: Tue, 21 Dec 2010 09:52:47 -0800
Message-ID: <4D10E96F.6070406@gmail.com>
References: <cover.1291820033.git.dirk.brandewie@gmail.com> <99ff131ecbee621f0d3178d6d3896d6f39207d6f.1291820034.git.dirk.brandewie@gmail.com> <4D10B8AA.3070500@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43366 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0LURwv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Dec 2010 12:52:51 -0500
In-Reply-To: <4D10B8AA.3070500@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sodaville@linutronix.de, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org

On 12/21/2010 06:24 AM, Michal Marek wrote:
> On 8.12.2010 16:01, dirk.brandewie@gmail.com wrote:
>> +quiet_cmd_dt_S_dtb= DTB    $@
>
>> +quiet_cmd_dtc = DTC $@
>
> Hi,
>
> just an aesthetic remark: The target name should start at the 9th
> column, so there should be 5 spaces after both "DTB" and "DTC".
>
> Michal
Thanks I will fix this.

--Dirk
