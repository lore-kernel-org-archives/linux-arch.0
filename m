From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 03/10] m32r: migrate exception table users off module.h
 and onto extable.h
Date: Tue, 10 Jan 2017 22:49:52 +0000
Message-ID: <58756510.4080301@gmail.com>
References: <20170109204010.5047-1-paul.gortmaker@windriver.com> <20170109204010.5047-4-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109204010.5047-4-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 09 January 2017 08:40 PM, Paul Gortmaker wrote:
> These files were only including module.h for exception table
> related functions.  We've now separated that content out into its
> own file "extable.h" so now move over to that and avoid all the
> extra header content in module.h that we don't really need to compile
> these files.
>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


regards
sudip
