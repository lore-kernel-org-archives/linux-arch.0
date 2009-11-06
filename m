Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:35880 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbZKFA4N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2009 19:56:13 -0500
Message-ID: <4AF37425.9060000@zytor.com>
Date: Thu, 05 Nov 2009 16:56:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 09/11] sysctl: x86 Use the compat_sys_sysctl
References: <m1tyx8trik.fsf@fess.ebiederm.org> <1257468114-6823-9-git-send-email-ebiederm@xmission.com>
In-Reply-To: <1257468114-6823-9-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20091106005605.Uu7rzq6mhUmG9h-Y6Cysp9ffG106CmbbjMm_ylgO5eY@z>

On 11/05/2009 04:41 PM, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> Now that we have a generic 32bit compatibility implementation
> there is no need for x86 to implement it's own.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: H. Peter Anvin <hpa@zytor.com>

I'm assuming based on your previous email that you'll hang on to this
patch and carry it yourself.

	-hpa
