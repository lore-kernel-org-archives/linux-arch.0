Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60993 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbbIOUo0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Sep 2015 16:44:26 -0400
Subject: Re: [PATCH 11/13] Always define MAX_RAW_MINORS as 65535 in userspace
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-12-git-send-email-palmer@dabbelt.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <55F882C7.4080304@zytor.com>
Date: Tue, 15 Sep 2015 13:42:47 -0700
MIME-Version: 1.0
In-Reply-To: <1442271047-4908-12-git-send-email-palmer@dabbelt.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, arnd@arndb.de, dhowells@redhat.com
Cc: viro@zeniv.linux.org.uk, ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net, dyoung@redhat.com, drysdale@google.com, davem@davemloft.net, ebiederm@xmission.com, geoff@infradead.org, gregkh@linuxfoundation.org, mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org, josh@joshtriplett.org, kexec@lists.infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com, x86@kernel.org
Message-ID: <20150915204247.1QEC1D8EpWADvkOG-EEUMgBd_l4srZcSNmY5dk2MEHg@z>

On 09/14/2015 03:50 PM, Palmer Dabbelt wrote:
> While I don't think this was ever meant to be exposed to userspace, if
> anyone is using it then this will at least provide a correct (if
> unlikely) definition.
> 
> MAX_RAW_MINORS used to be used in the kernel, where it's been replaced
> with CONFIG_MAX_RAW_MINORS.
> 
> Note that there's a checkpatch.pl warning about a split config string
> here, but I've left that alone.
