From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 05/14] prctl.2: tfix listing order of prctls
Date: Wed, 13 May 2020 12:10:53 +0200
Message-ID: <1bb991f4-176a-a74e-01fc-c73b49ed77f5@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-6-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgEMKKz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:10:55 -0400
In-Reply-To: <1589301419-24459-6-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> The prctl list has historically been sorted by prctl name (ignoring
> any SET_ or GET_ prefix) to make individual prctls easier to find.
> Some noise seems to have crept in since.
> 
> Sort the list back into order.  Similarly, reorder the list of
> prctls specified to return non-zero values on success.

This is a good patch. But see my comments on patch 04.
I'd prefer a patch like this at the end of a series, 
rather than in the middle of it.

> Content movement only.  No semantic change.

And explicitly noting that detail is very helpful to me.

Patch applied.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 138 +++++++++++++++++++++++++++++------------------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index e5b2b4b..1611448 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -490,6 +490,52 @@ Pass \fBPR_FP_EXC_SW_ENABLE\fP to use FPEXC for FP exception enables,
>  Return floating-point exception mode,
>  in the location pointed to by
>  .IR "(int\ *) arg2" .
> +.\" prctl PR_SET_IO_FLUSHER
> +.TP
> +.BR PR_SET_IO_FLUSHER " (since Linux 5.6)"
> +If a user process is involved in the block layer or filesystem I/O path,
> +and can allocate memory while processing I/O requests it must set
> +\fIarg2\fP to 1.
> +This will put the process in the IO_FLUSHER state,
> +which allows it special treatment to make progress when allocating memory.
> +If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and
> +the default behavior will be used.
> +.IP
> +The calling process must have the
> +.BR CAP_SYS_RESOURCE
> +capability.
> +.IP
> +.IR arg3 ,
> +.IR arg4 ,
> +and
> +.IR arg5
> +must be zero.
> +.IP
> +The IO_FLUSHER state is inherited by a child process created via
> +.BR fork (2)
> +and is preserved across
> +.BR execve (2).
> +.IP
> +Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
> +emulation daemons, and daemons that perform error handling like multipath
> +path recovery applications.
> +.\" prctl PR_GET_IO_FLUSHER
> +.TP
> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
> +Return (as the function result) the IO_FLUSHER state of the caller.
> +A value of 1 indicates that the caller is in the IO_FLUSHER state;
> +0 indicates that the caller is not in the IO_FLUSHER state.
> +.IP
> +The calling process must have the
> +.BR CAP_SYS_RESOURCE
> +capability.
> +.IP
> +.IR arg2 ,
> +.IR arg3 ,
> +.IR arg4 ,
> +and
> +.IR arg5
> +must be zero.
>  .\" prctl PR_SET_KEEPCAPS
>  .TP
>  .BR PR_SET_KEEPCAPS " (since Linux 2.2.18)"
> @@ -1207,23 +1253,6 @@ call failing with the error
>  .BR ENXIO .
>  For further details, see the kernel source file
>  .IR Documentation/admin-guide/kernel-parameters.txt .
> -.\" prctl PR_SET_THP_DISABLE
> -.TP
> -.BR PR_SET_THP_DISABLE " (since Linux 3.15)"
> -.\" commit a0715cc22601e8830ace98366c0c2bd8da52af52
> -Set the state of the "THP disable" flag for the calling thread.
> -If
> -.I arg2
> -has a nonzero value, the flag is set, otherwise it is cleared.
> -Setting this flag provides a method
> -for disabling transparent huge pages
> -for jobs where the code cannot be modified, and using a malloc hook with
> -.BR madvise (2)
> -is not an option (i.e., statically allocated data).
> -The setting of the "THP disable" flag is inherited by a child created via
> -.BR fork (2)
> -and is preserved across
> -.BR execve (2).
>  .\"
>  .\" prctl PR_TASK_PERF_EVENTS_DISABLE
>  .TP
> @@ -1256,6 +1285,23 @@ renamed
>  .\" commit cdd6c482c9ff9c55475ee7392ec8f672eddb7be6
>  in Linux 2.6.32.
>  .\"
> +.\" prctl PR_SET_THP_DISABLE
> +.TP
> +.BR PR_SET_THP_DISABLE " (since Linux 3.15)"
> +.\" commit a0715cc22601e8830ace98366c0c2bd8da52af52
> +Set the state of the "THP disable" flag for the calling thread.
> +If
> +.I arg2
> +has a nonzero value, the flag is set, otherwise it is cleared.
> +Setting this flag provides a method
> +for disabling transparent huge pages
> +for jobs where the code cannot be modified, and using a malloc hook with
> +.BR madvise (2)
> +is not an option (i.e., statically allocated data).
> +The setting of the "THP disable" flag is inherited by a child created via
> +.BR fork (2)
> +and is preserved across
> +.BR execve (2).
>  .\" prctl PR_GET_THP_DISABLE
>  .TP
>  .BR PR_GET_THP_DISABLE " (since Linux 3.15)"
> @@ -1438,67 +1484,21 @@ system call on Tru64).
>  for information on versions and architectures.)
>  Return unaligned access control bits, in the location pointed to by
>  .IR "(unsigned int\ *) arg2" .
> -.\" prctl PR_SET_IO_FLUSHER
> -.TP
> -.BR PR_SET_IO_FLUSHER " (since Linux 5.6)"
> -If a user process is involved in the block layer or filesystem I/O path,
> -and can allocate memory while processing I/O requests it must set
> -\fIarg2\fP to 1.
> -This will put the process in the IO_FLUSHER state,
> -which allows it special treatment to make progress when allocating memory.
> -If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and
> -the default behavior will be used.
> -.IP
> -The calling process must have the
> -.BR CAP_SYS_RESOURCE
> -capability.
> -.IP
> -.IR arg3 ,
> -.IR arg4 ,
> -and
> -.IR arg5
> -must be zero.
> -.IP
> -The IO_FLUSHER state is inherited by a child process created via
> -.BR fork (2)
> -and is preserved across
> -.BR execve (2).
> -.IP
> -Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
> -emulation daemons, and daemons that perform error handling like multipath
> -path recovery applications.
> -.\" prctl PR_GET_IO_FLUSHER
> -.TP
> -.B PR_GET_IO_FLUSHER (Since Linux 5.6)
> -Return (as the function result) the IO_FLUSHER state of the caller.
> -A value of 1 indicates that the caller is in the IO_FLUSHER state;
> -0 indicates that the caller is not in the IO_FLUSHER state.
> -.IP
> -The calling process must have the
> -.BR CAP_SYS_RESOURCE
> -capability.
> -.IP
> -.IR arg2 ,
> -.IR arg3 ,
> -.IR arg4 ,
> -and
> -.IR arg5
> -must be zero.
>  .SH RETURN VALUE
>  On success,
> +.BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,
> +.BR PR_CAPBSET_READ ,
>  .BR PR_GET_DUMPABLE ,
>  .BR PR_GET_FP_MODE ,
> +.BR PR_GET_IO_FLUSHER ,
>  .BR PR_GET_KEEPCAPS ,
> +.BR PR_MCE_KILL_GET ,
>  .BR PR_GET_NO_NEW_PRIVS ,
> +.BR PR_GET_SECUREBITS ,
> +.BR PR_GET_SPECULATION_CTRL ,
>  .BR PR_GET_THP_DISABLE ,
> -.BR PR_CAPBSET_READ ,
>  .BR PR_GET_TIMING ,
>  .BR PR_GET_TIMERSLACK ,
> -.BR PR_GET_SECUREBITS ,
> -.BR PR_GET_SPECULATION_CTRL ,
> -.BR PR_MCE_KILL_GET ,
> -.BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,
> -.BR PR_GET_IO_FLUSHER ,
>  and (if it returns)
>  .BR PR_GET_SECCOMP
>  return the nonnegative values described above.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
