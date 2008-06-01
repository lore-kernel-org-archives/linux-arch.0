From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/10] Add generic helpers for arch IPI function calls
 #4
Date: Sun, 01 Jun 2008 10:52:29 +0100
Message-ID: <4842715D.9090304@goop.org>
References: <1212051504-12561-1-git-send-email-jens.axboe@oracle.com> <20080601015708.917e11c9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:35752 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161AbYFAJxI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Jun 2008 05:53:08 -0400
In-Reply-To: <20080601015708.917e11c9.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

Andrew Morton wrote:
> On Thu, 29 May 2008 10:58:14 +0200 Jens Axboe <jens.axboe@oracle.com> wrote:
>
>   
>> Jeremy sent me a ping about this patchset, so here's an updated
>> version against the current kernel (2.6.26-rc4'ish).
>>     
>
> If we're having 2.6.27 thoughts about this work then we should get it
> into linux-next pretty soon, please.
>   

The x86 parts clash fairly thoroughly with the tip.git x86 work.  
Nothing deep; just that various files it tries to patch are now 
unified.  From a purely selfish perspective, I'd like to see this series 
end up as a topic branch in tip.git.

    J
