From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 09/11] sysctl: x86 Use the compat_sys_sysctl
Date: Thu, 05 Nov 2009 16:56:05 -0800
Message-ID: <4AF37425.9060000@zytor.com>
References: <m1tyx8trik.fsf@fess.ebiederm.org> <1257468114-6823-9-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757898AbZKFA4P@vger.kernel.org>
In-Reply-To: <1257468114-6823-9-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

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
