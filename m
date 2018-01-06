From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 15/18] vfs, fdtable: prevent bounds-check bypass via
 speculative execution
Date: Sat, 6 Jan 2018 13:05:40 +0300
Message-ID: <07835e19-baef-81a0-b921-5bae491f03f6@cogentembedded.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520107515.32271.4902355030043648595.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37967 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbeAFKFn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 05:05:43 -0500
Received: by mail-lf0-f65.google.com with SMTP id w196so7507394lff.5
        for <linux-arch@vger.kernel.org>; Sat, 06 Jan 2018 02:05:42 -0800 (PST)
In-Reply-To: <151520107515.32271.4902355030043648595.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

On 1/6/2018 4:11 AM, Dan Williams wrote:

> Expectedly, static analysis reports that 'fd' is a user controlled value
> that is used as a data dependency to read from the 'fdt->fd' array.  In
> order to avoid potential leaks of kernel memory values, block
> speculative execution of the instruction stream that could issue reads
> based on an invalid 'file *' returned from __fcheck_files.
> 
> Based on an original patch by Elena Reshetova.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   include/linux/fdtable.h |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index 1c65817673db..4a147c5c2533 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -81,9 +81,10 @@ struct dentry;
>   static inline struct file *__fcheck_files(struct files_struct *files, unsigned int fd)
>   {
>   	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
> +	struct file __rcu **fdp;
>   
> -	if (fd < fdt->max_fds)
> -		return rcu_dereference_raw(fdt->fd[fd]);
> +	if ((fdp = nospec_array_ptr(fdt->fd, fd, fdt->max_fds)))

    And here...

> +		return rcu_dereference_raw(*fdp);
>   	return NULL;
>   }
>   

MMR, Sergei
