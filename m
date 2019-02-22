Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20829 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfBVXDQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 18:03:16 -0500
Subject: Re: [PATCH v10 06/12] fs, arm64: untag user pointers in
 copy_mount_options
References: <cover.1550839937.git.andreyknvl@google.com>
 <a958e202cdbe6e1bac8a37b7f3d9881d1b22993d.1550839937.git.andreyknvl@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a38275b0-f6cd-20e1-3c48-544846586a16@intel.com>
Date: Fri, 22 Feb 2019 15:03:15 -0800
MIME-Version: 1.0
In-Reply-To: <a958e202cdbe6e1bac8a37b7f3d9881d1b22993d.1550839937.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190222230315.eXFq-0noxcL7T_g5z7-nrZkFaPaErlQATq5vDdm-jok@z>

On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2730,7 +2730,7 @@ void *copy_mount_options(const void __user * data)
>  	 * the remainder of the page.
>  	 */
>  	/* copy_from_user cannot cross TASK_SIZE ! */
> -	size = TASK_SIZE - (unsigned long)data;
> +	size = TASK_SIZE - (unsigned long)untagged_addr(data);
>  	if (size > PAGE_SIZE)
>  		size = PAGE_SIZE;

I would have thought that copy_from_user() *is* entirely capable of
detecting and returning an error in the case that its arguments cross
TASK_SIZE.  It will fail and return an error, but that's what it's
supposed to do.

I'd question why this code needs to be doing its own checking in the
first place.  Is there something subtle going on?
